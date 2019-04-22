import json

from django.views.decorators.csrf import csrf_exempt
from django.http import HttpResponseNotAllowed, JsonResponse

from products.forms import ProductForm
from products.models import Product


@csrf_exempt
def create_product(request):
    if request.method != "POST":
        return HttpResponseNotAllowed(["POST"])

    product_data = json.loads(request.body)
    form = ProductForm(product_data)
    if form.is_valid():
        saved = form.save()
        return JsonResponse({"status": "Created", "id": saved.pk},
                            status=201)
    else:
        return JsonResponse(form.errors, status=400)


def list_products(request):
    products = Product.objects.all().values()
    products = list(products)

    return JsonResponse(products, safe=False)


def version(request):
    return JsonResponse({"version": "1.0.0"})
